<?php
require_once __DIR__ . '/../model/Produto.php';
require_once __DIR__ . '/../library/Conexao.class.php';

class ProdutoDAL
{

    /**
     *
     * @var Database
     */
    private static $connection = null;

    private static function connect()
    {
        if (is_null(ProdutoDAL::$connection)) {
            ProdutoDAL::$connection = new Database();
        }
    }

    public static function insereProduto(Produto $prod): string
    {
        ProdutoDAL::connect();
        
        $descProd = $prod->getDescProd();
        $descComp = $prod->getDescCompletaProd();
        $prodStatus = $prod->getStatusProd();
        
        $categID = $prod->getIdCateg();
        
        $sql = "INSERT INTO PRODUTO (PRODUTO_cDESC, PRODUTO_cDESCCOMPLETA, PRODUTO_cSTATUS)
        VALUES ('$descProd','$descComp','$prodStatus')";
        
        if (ProdutoDAL::$connection->sqlNoTransact($sql)) {
            
            $id = ProdutoDAL::$connection->returnID();
            
            foreach ($categID as $cId) {
                
                $sql = "INSERT INTO PRODUTO_CATEGORIA (CATEGORIA_nID, PRODUTO_nID) VALUES ($cId,$id)";
                ProdutoDAL::$connection->executarSQL($sql);
            }
            
            return $id;
        }
    }

    public static function atualizaProduto(Produto $prod): string
    {
        ProdutoDAL::connect();
        
        $idProd = $prod->getIdProd();
        $descProd = $prod->getDescProd();
        $descComp = $prod->getDescCompletaProd();
        $prodStatus = $prod->getStatusProd();
        $modeloID = $prod->getIdModelo();
        $categID = $prod->getIdCateg();
        $categoriaDesc = $prod->getDescCateg();
        
        $sql = "";
        
        return ProdutoDAL::$connection->executarSQL($sql);
    }

    public static function buscaProduto($id = null)
    {
        ProdutoDAL::connect();
        
        if (!empty($id)) {
            
//             $id = $prod->getIdProd();
            
            $sql = "SELECT * FROM PRODUTO
                       INNER JOIN MODELO ON PRODUTO.PRODUTO_nID = MODELO.PRODUTO_nID
                         WHERE PRODUTO_cSTATUS LIKE 'Ativo' and MODELO_nSTATUS like 'Ativo' and 
                            MODELO_nQTD_ESTOQUE > 0 and PRODUTO.PRODUTO_nID = $id";
        } else {
            $sql = "SELECT * FROM PRODUTO";
        }
        
        ProdutoDAL::$connection->executarSQL($sql);
        
        $resultados = ProdutoDAL::$connection->getResultados();
        
        $arrayProd = array();
        
        foreach ($resultados as $resultado) {
            
            $resultProduto = new Produto();
            
            $resultProduto->setIdProd($resultado['PRODUTO_nID']);
            $resultProduto->setDescProd($resultado['PRODUTO_cDESC']);
            $resultProduto->setDescCompletaProd($resultado['PRODUTO_cDESCCOMPLETA']);
            $resultProduto->setStatusProd($resultado['PRODUTO_cSTATUS']);
            
            $arrayProd[] = $resultProduto;
        }
        
        return $arrayProd;
    }

    public static function deletaProduto(Produto $prod): string
    {
        ProdutoDAL::connect();
        $idProd = $prod->getIdProd();
        $sql = "DELETE FROM PRODUTO WHERE PRODUTO_nID = $idProd";
        
        try {
            ProdutoDAL::$connection->executarSQL($sql);
        } catch (Exception $e) {
            echo $e;
        }
    }
}